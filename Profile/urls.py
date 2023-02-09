"""Profile URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from home import views as v1
from shop import views as v2
from spons_products import views as v3 
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path("admin/", admin.site.urls),
    path("home/", v1.home_view),
    path("contact_me/", v1.contact_form2),
    path("send-message/", v1.contact_formtest),
    path("test-page1/", v1.temp_view),
    path('test1/', include('shop.urls', namespace='shop')),
    path('test2/', v2.product_list),
    path('store/', include('shop.urls', namespace='shop')),
    path("view-spons-product/",v3.product_detail_view ,name='spons_product'),
    path("create-spons-product/",v3.product_create_view ,name='create_spons_product'),

]
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)
