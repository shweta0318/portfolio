from django.shortcuts import render

from .forms import messageForms
# Create your views here.
from django.http import HttpResponse

def home_view(request,*args,**kwargs):
    print(args,kwargs)
    print(request.user)
    #return HttpResponse("<h1>Hello World Django</h1>")
    return render(request,"home_main.html")

def contact_form(request,*args,**kwargs):
    print(args,kwargs)
    print(request.user)
    #return HttpResponse("<h1>Hello World Django</h1>")
    return render(request,"contact_form.html")


def contact_formtest(request):
    form = messageForms(request.POST or None)
    if form.is_valid():
        form.save()
        form = messageForms

    context = {
        'form' : form
    }

    return render(request,'contact_form_test.html',context)

def contact_form2(request):
    form = messageForms(request.POST or None)
    if form.is_valid():
        form.save()
        form = messageForms

    context = {
        'form' : form
    }

    return render(request,'contact_form2.html',context)


def temp_view(request,*args,**kwargs):
    my_context = {
        "my_text" : "this is just a test page passing parameter text",
        "my_number" : "123"
    }
   
    
    return render(request,"testpage.html",my_context)