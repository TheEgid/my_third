import pytest
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from django.conf import settings


@pytest.fixture(scope="class")
def setup_browser(request):

    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--headless=True")
    chrome_options.add_argument("--log-level=3")
    if settings.OPERATING_SYSTEM == "Windows":
        browser = webdriver.Chrome(options=chrome_options)
    else:  # Linux
        selenium_hub_url = 'http://hub:4444/wd/hub'
        browser = webdriver.Remote(
                command_executor=selenium_hub_url,
                desired_capabilities=DesiredCapabilities.CHROME,
                options=chrome_options)

    request.cls.browser = browser
    browser.implicitly_wait(2)

    yield browser

    browser.close()
