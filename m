From: Sven Geggus <lists@fuchsschwanzdomain.de>
Subject: Using Multiple SEARCH_BASE entries
Date: Fri, 7 Feb 2014 15:11:30 +0100
Message-ID: <20140207141130.GA18340@geggus.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Hello,

while migrating my autofs entries to another directory server I also tried
to split the entries by organisational units.

For this purpose I put the following in /etc/default/autofs:
SEARCH_BASE="ou=autofs,OU=department1,OU=myplace,OU=mydivision,dc=mycompany,DC=com"
SEARCH_BASE="ou=autofs,OU=department2,OU=myplace,OU=mydivision,dc=mycompany,DC=com"

Autofs schema is NIS style because this is the only one which active directory
and Samba4 support without too much hassle.

However, the splitting does not seem to work.

It is always using the first entry only:

...
get_query_dn: lookup(ldap): found search base under ou=autofs,OU=department1,OU=myplace,OU=mydivision,dc=mycompany,DC=com
get_query_dn: lookup(ldap): found query dn CN=auto.master,OU=autofs,OU=department1,OU=myplace,OU=mydivision,dc=mycompany,DC=com
...

Changing SEARCH_BASE to the following does not help either:
SEARCH_BASE="OU=myplace,OU=mydivision,dc=mycompany,DC=com"

...
get_query_dn: lookup(ldap): found search base under OU=myplace,OU=mydivision,dc=mycompany,DC=com"
get_query_dn: lookup(ldap): found query dn CN=auto.master,OU=autofs,OU=department2,OU=myplace,OU=mydivision,dc=mycompany,DC=com"
...

No idea why it ends up using department2 in the second case.

Any Idea?

Regards

Sven

P.S.: My autofs version is 5.0.7-3 from Debian 7.0

-- 
Those who would give up Essential Liberty to purchase a little Temporary
Safety, deserve neither Liberty nor Safety (Benjamin Franklin)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web
