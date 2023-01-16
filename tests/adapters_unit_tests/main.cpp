#include <gtest/gtest.h>
#include "authentication_controller_tests.hpp"
#include "authentication_gateway_tests.hpp"
#include "book_controller_tests.hpp"
#include "book_storage_gateway_tests.hpp"
#include "library_proxy_model_tests.hpp"
#include "settings_controller_tests.hpp"
#include "user_controller_tests.hpp"
#include "user_storage_gateway_tests.hpp"

int main()
{
    testing::InitGoogleTest();


    return RUN_ALL_TESTS();
}