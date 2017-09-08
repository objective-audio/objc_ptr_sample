//
//  objc_ptr.hpp
//

#pragma once

#include <memory>
#include <functional>

template <typename T>
class objc_impl {
   public:
    T const value;

    objc_impl(T value) : value(value) {
        [value retain];
    }

    ~objc_impl() {
        [value release];
    }
};

template <typename T>
class weak_objc_ptr;

template <typename T>
class objc_ptr {
    friend class weak_objc_ptr<T>;

    std::shared_ptr<objc_impl<T>> _impl;

    objc_ptr(std::shared_ptr<objc_impl<T>> holder) : _impl(holder) {
    }

   public:
    objc_ptr() : objc_ptr(nil) {
    }

    objc_ptr(T value) : _impl(std::make_shared<objc_impl<T>>(value)) {
    }

    objc_ptr(std::function<T(void)> handler) {
        @autoreleasepool {
            _impl = std::make_shared<objc_impl<T>>(handler());
        }
    }

    T value() const {
        return _impl->value;
        // あるいは
        // return [[_impl->value retain] autorelease];
    }

    T operator*() const {
        return _impl->value;
    }

    explicit operator bool() const {
        return _impl->value != nil;
    }
};

template <typename T>
objc_ptr<T> make_objc_ptr(T value) {
    objc_ptr<T> ptr(value);
    [value release];
    return ptr;
}

template <typename T>
class weak_objc_ptr {
    std::weak_ptr<objc_impl<T>> _impl;

   public:
    weak_objc_ptr() = default;

    weak_objc_ptr(objc_ptr<T> ptr) : _impl(ptr._impl) {
    }

    objc_ptr<T> lock() const {
        if (auto locked = _impl.lock()) {
            return objc_ptr<T>(locked);
        } else {
            return objc_ptr<T>();
        }
    }
};

template <typename T>
weak_objc_ptr<T> to_weak(objc_ptr<T> ptr) {
    return weak_objc_ptr<T>(ptr);
}
