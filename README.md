# README

This is demo rails application that was spike as a proof of concept to be able to access a Microsoft Dynamics CRM with a Ruby client. It was intended to complement the panellist prototype found here https://github.com/DFE-Digital/refer-serious-misconduct-by-a-teacher-prototype/tree/main/app/views/panellist/v1

However it could be used to access any MS Dynamics CRM instance.

## Setup

Before this app can be used you must get hold of some credentials to be able to access your Dynamics instance. This was in this instance an `Application User` that had access to the relevant environment.

In order to gain access to a Dynamics instance you will need to collect the following information then add them to the codebase

- `tenant` - this is the `tenant_id` of where the Dynamics instance resides and is a GUID
- `resource` - this is the base url of where to access to Dynamics instance
- `client_id` - this is a GUID of the client credentials
- `client_secret` - this is a 40 character string and the secret for the credential pair

## Usage

After starting the server:

- `http://localhost:3000/entities` will list all entities available
- `http://localhost:3000/entities/contacts` will list all contacts assuming contacts exists or could be any other resource
- `http://localhost:3000/entities/contacts?filters[emailaddress1]=someone@example.com` allows you to filter by attribute with a given value

After starting a console:

To create an instance of a client:
```
client = Services::CrmClient.new
```

To update an existing record:
```
client.update(resource: "contacts(contact-guid-goes-here)", attributes: { key_to_change: "new_value_here" })
```
