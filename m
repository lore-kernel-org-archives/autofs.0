From: Sven Geggus <lists@fuchsschwanzdomain.de>
Subject: Re: Using Multiple SEARCH_BASE entries
Date: Sun, 9 Feb 2014 18:53:41 +0100
Message-ID: <20140209175341.GA5225@geggus.net>
References: <20140207141130.GA18340@geggus.net>
 <1391912857.2531.3.camel@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391912857.2531.3.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Ian Kent schrieb am Sonntag, den 09. Februar um 03:27 Uhr:

> I think you'll need to describe the structure of your LDAP entries, how
> you expect them to be accessed, and how you expect they will be
> differentiated one for the other.

Hm, would I need a SEARCH_BASE entry for each department or would it
be enough to have one with OU=myplace,OU=mydivision,DC=mycompany,DC=com only?

All I want to have is home directory mappings for users from
different departments like this:

/home/user1 (from depatment 1) mapped to server1.mycompany.com:/storage/home/user1
/home/user2 (from depatment 1) mapped to server2.mycompany.com:/storage/home/user2

The different subtrees in ldap are for organizational purposes only
(writable by admin1, admin2, ..) but should work the same as far as
autofs is concerned. This worked fine with both user entries in one
hierachy of ldap but currently does not work with if I separate them
by OU=department1/OU=department2.

Here is what all my ldap entries (currently only for two test users:
user1 from department1 and user2 from department2) look like:

dn: CN=auto.master,OU=autofs,OU=department1,OU=myplace,OU=mydivision,DC=mycompany,DC=com
objectClass: top
objectClass: nisMap
cn: auto.master
name: auto.master
nisMapName: auto.master

dn: CN=auto.home,OU=autofs,OU=department1,OU=myplace,OU=mydivision,DC=mycompany,DC=com
objectClass: top
objectClass: nisMap
cn: auto.home
name: auto.home
nisMapName: auto.home

dn: CN=auto.master,OU=autofs,OU=department2,OU=myplace,OU=mydivision,DC=mycompany,DC=com
objectClass: top
objectClass: nisMap
cn: auto.master
name: auto.master
nisMapName: auto.master

dn: CN=auto.home,OU=autofs,OU=department2,OU=myplace,OU=mydivision,DC=mycompany,DC=com
objectClass: top
objectClass: nisMap
cn: auto.home
name: auto.home
nisMapName: auto.home

dn: CN=/home,CN=auto.master,OU=autofs,OU=department1,OU=myplace,OU=mydivision,DC=mycompany,DC=com
objectClass: top
objectClass: nisObject
cn: /home
name: /home
nisMapEntry: auto.home
nisMapName: auto.master

dn: CN=user1,CN=auto.home,OU=autofs,OU=department1,OU=myplace,OU=mydivision,DC=mycompany,DC=com
objectClass: top
objectClass: nisObject
cn: user1
name: user1
nisMapEntry: -fstype=nfs4,sec=krb5 server1.mycompany.com:/storage/home/user1
nisMapName: auto.home

dn: CN=/home,CN=auto.master,OU=autofs,OU=department2,OU=myplace,OU=mydivision,DC=mycompany,DC=com
objectClass: top
objectClass: nisObject
cn: /home
name: /home
nisMapEntry: auto.home
nisMapName: auto.master

dn: CN=user2,CN=auto.home,OU=autofs,OU=department2,OU=myplace,OU=mydivision,DC=mycompany,DC=com
objectClass: top
objectClass: nisObject
cn: user2
name: user2
nisMapEntry: -fstype=nfs4,sec=krb5 server2.mycompany.com:/storage/home/user2
nisMapName: auto.home

> No idea, could be a problem with the lookup, can't tell without more
> information.

What else do you need? More Output from "automount -f -v -d"?

Regards

Sven

P.S.: Regarding the Version. Looks like Debian applied a couple of
minor patches to vanilla autofs 5.0.7, but none of them seems to be
ldap related.

-- 
"I'm a bastard, and proud of it"
                          (Linus Torvalds, Wednesday Sep 6, 2000)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web
