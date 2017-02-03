
context("macOS keyring")

test_that("set, get, delete", {
  skip_if_not_macos()

  service <- random_service()
  username <- random_username()
  password <- random_password()

  backend <- backend_macos()

  expect_silent(
    key_set_with_value(service, username, password, backend = backend)
  )

  expect_equal(key_get(service, username, backend = backend), password)

  expect_silent(key_delete(service, username, backend = backend))
})

test_that("set can update", {
  skip_if_not_macos()

  service <- random_service()
  username <- random_username()
  password <- random_password()

  backend <- backend_macos()

  expect_silent({
    key_set_with_value(service, username, "foobar", backend = backend)
    key_set_with_value(service, username, password, backend = backend)
  })

  expect_equal(key_get(service, username, backend = backend), password)
})

test_that("list", {
  skip_if_not_macos()

  service <- random_service()
  username <- random_username()
  password <- random_password()

  backend <- backend_macos()

  expect_silent({
    key_set_with_value(service, username, password, backend = backend)
    list <- key_list(backend = backend)
  })

  expect_equal(list$username[match(service, list$service)], username)
})