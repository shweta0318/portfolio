from django.db import models

# Create your models here.
class message(models.Model):
    name = models.TextField(max_length=50,blank=True,null=True,help_text="enter your name")
    text = models.TextField(max_length=1000,help_text="enter your message , ending with your details,contact number and phone number")