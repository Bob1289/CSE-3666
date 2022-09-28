import requests
from bs4 import BeautifulSoup


url = "https://www.kaltura.com/index.php/extwidget/preview/partner_id/2090521/uiconf_id/38934061/entry_id/1_imt69h53/embed/dynamic?"
r1 = requests.get(url, stream=True)
filename = "stream.avi"



