from django import forms

from .models import products

class ProductForm(forms.ModelForm):
    class Meta:
        model = products
        fields = [
            "title",
            "description",
            "price"
        ]

class RawProductForms(forms.Form):
    title = forms.CharField()
    description = forms.CharField()
    price = forms.DecimalField()