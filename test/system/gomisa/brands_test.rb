require "application_system_test_case"

class Gomisa::BrandsTest < ApplicationSystemTestCase
  setup do
    @gomisa_brand = gomisa_brands(:one)
  end

  test "visiting the index" do
    visit gomisa_brands_url
    assert_selector "h1", text: "Gomisa/Brands"
  end

  test "creating a Brand" do
    visit gomisa_brands_url
    click_on "New Gomisa/Brand"

    click_on "Create Brand"

    assert_text "Brand was successfully created"
    click_on "Back"
  end

  test "updating a Brand" do
    visit gomisa_brands_url
    click_on "Edit", match: :first

    click_on "Update Brand"

    assert_text "Brand was successfully updated"
    click_on "Back"
  end

  test "destroying a Brand" do
    visit gomisa_brands_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Brand was successfully destroyed"
  end
end
