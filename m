From: Sohnaeo <trysomefun@gmail.com>
Subject: Autmount issue
Date: Thu, 21 May 2015 12:42:32 +1000
Message-ID: <CABJoi6w9OgxBtUSARsaAvxAWt_ViJzh_6BYn_g214KnwmRFMAw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=49PWG9ty76uDucoNxxuDnZvzj3BvZvfwfEeE+mWiudY=;
        b=ibXZZtWFHaxxiv+BM7ea3fTXv7zS9W3meUj9UyYsqKdE+0uanm89GEUYnLwQqU6ODH
         dgj9t5r0BDjMS5pKbtn8P1+0tLY1mndhC2bdnMg9U1ZIN7UlIYBwHIt5s1E+UwjyRnKV
         j1DWQluflBFa4vAOuOFSpmSuXaj1TmRwm5TFbKM9DNjKbvXpDiwnxnOb2TOPslDKJMh0
         uOjTDuNCcT5XwIi1/hTr2vxzicbmB7YlWjOQtewagGVXLDBxu6aMT6mwSosJhVk2xVnU
         +mQM0FriMIYDNpR5nAoPDhQoDQELPns13TFm408ijGMsy/pF+CdK2hwJdFfk1UujAT3T
         vu/g==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hello Guys,

I am having an issue with the autofs/automount on Cent OS 7, below is the detail

LDAP Server


Solaris 10
Sun Directory Server 6.2


LDAP Client


CentOS 7

OpenLdap


I issued the below command to enable LDAP authetication. LDAP users
can successfully authenticated now on CentOs

 authconfig --enableldap --enableldapauth --ldapserver=x.x.x.x
--ldapbasedn=dc=drivess,dc=rtta --disablemkhomedir --update

But somehow users home directories can't be mounted through autofs.
Below is my autofs.conf file

 autofs
master_map_name = ldap://xxxxx/automountMapName=auto_master,dc=drivess,dc=rtaa
mount_nfs_default_protocol = 3
logging = debug
ldap_uri = "ldap://x.x.x.x"
search_base = "automountMapName=auto_master,dc=drivess,dc=rtaa"
map_object_class = automountMap
entry_object_class = automount
map_attribute = automountMapName
entry_attribute = automountKey
value_attribute= automountInformation
auth_conf_file = /etc/autofs_ldap_auth.conf
map_type = ldap

When I run the below command , it throws an error

automount -m
get_query_dn: lookup(ldap): found query dn
automountMapName=auto_master,dc=drivess,dc=rtaa
lookup_read_master: lookup(ldap): searching for
"(objectclass=automount)" under
"automountMapName=auto_master,dc=drivess,dc=rtaa"
lookup_read_master: lookup(ldap): examining entries
syntax error in map near  ahmedf nfs-cluster:

Below is ldapsearch command result
  ldapsearch -x -b 'automountMapName=auto_master,dc=drivess,dc=rtaa'
"(objectClass=automountMap)"

dn: automountMapName=auto_master,dc=drivess,dc=rtaa
automountMapName: auto_master
objectClass: top
objectClass: automountMap

 ldapsearch -x -b
'automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
dn: automountkey=ahmedf,automountMapName=auto_master,dc=drivess,dc=rtaa
automountInformation: nfs-cluster:/san/users/cmes/ahmedf
automountKey: ahmedf
objectClass: automount
objectClass: top

In short, automountInformation is nfs-cluster:/san/users/cmes/ahmedf
but somehow autmount is complaining "syntax error in map near [ ahmedf
nfs-cluster: ]"


Any ideas?
