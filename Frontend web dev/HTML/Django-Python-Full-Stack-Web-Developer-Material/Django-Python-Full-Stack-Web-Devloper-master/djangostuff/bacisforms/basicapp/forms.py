from django import forms
from django.core.exceptions import ValidationError
from django.core.validators import MaxLengthValidator
from django.core import validators


def check_for_z(value):
    if value[0].lower() != 'z':
        raise forms.ValidationError('name needs z')

class FormName(forms.Form):

    name = forms.CharField(validators=[check_for_z])
    email = forms.EmailField()
    text = forms.CharField(widget=forms.Textarea)
    verify_email = forms.EmailField(label='enter the email again')

    def clean(self):
        all_clean_data = super().clean()
        email = all_clean_data['email']
        vmail = all_clean_data['verify_email']
        if vmail != email:
            raise ValidationError('eeero ')


    botcatcher = forms.CharField(required=False,
                                widget=forms.HiddenInput,
                                validators=[validators.MaxLengthValidator(0)])

'''    def clean_botcatcher(self):
        botcatcher = self.cleaned_data['botcatcher']
        if len(botcatcher)>0:
            raise forms.ValidationError("bot!")
'''
