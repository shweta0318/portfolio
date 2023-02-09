from django import forms

from .models import message

class messageForms(forms.ModelForm):
    class Meta :
        model = message
        fields = [
            "text"
        ]