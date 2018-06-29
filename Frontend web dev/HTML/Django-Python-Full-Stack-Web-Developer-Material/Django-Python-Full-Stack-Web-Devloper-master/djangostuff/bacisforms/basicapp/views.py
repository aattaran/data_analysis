from django.shortcuts import render

# Create your views here.
from . import forms


def index(req):
    return render(req,'basicapp/index.html')

def form_name_view(request):
    form = forms.FormName()

    if request.method=="POST":
        form = forms.FormName(request.POST)

        if form.is_valid():

            print('validation process')
            print('name: '+form.cleaned_data['name'])
            print('name: '+form.cleaned_data['email'])
            print('name: '+form.cleaned_data['text'])


    return render(request,'basicapp/form_page.html',context={'form':form})
