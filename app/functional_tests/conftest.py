import pytest
from selenium import webdriver
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from django.conf import settings


@pytest.fixture(scope="class")
def setup_browser(request):
    options = Options()

    options.headless = True

    if settings.OPERATING_SYSTEM == "Windows":
        browser = webdriver.Firefox(options=options)
    else:  # Linux
        selenium_hub_url = 'http://hub:4444/wd/hub'
        browser = webdriver.Remote(
            command_executor=selenium_hub_url,
            desired_capabilities=DesiredCapabilities.FIREFOX,
            options=options)

    request.cls.browser = browser
    browser.implicitly_wait(time_to_wait=settings.SELENIUM_WAIT)

    yield browser

    browser.close()
