from django.shortcuts import render

# Create your views here.
from .models import products

from .forms import ProductForm,RawProductForms

# Create your views here.
def product_detail_view(request):
    obj = products.objects.get(id=5)
    # context = {
    #     'title' : obj.title,
    #     'description' : obj.description
    # }
    context = {
        'object' : obj
    }
    return render(request,'product_view.html',context)


#the view from the forms class ProductForms

def product_create_view(request):
     form = ProductForm(request.POST or None)
     if form.is_valid():
         form.save()
         form = ProductForm()

     context = {
         'form' : form
     }
     return render(request,'product_create.html',context)
