From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: Re: autofs5 + ldap + ldap replication
Date: Tue, 07 Aug 2007 09:33:13 -0500
Message-ID: <46B882A9.2040108@cs.ou.edu>
References: 46A62F05.4040806@wesmo.com <46B7CBBA.7080105@wesmo.com>
Reply-To: jsummers@bachman.cs.ou.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46B7CBBA.7080105@wesmo.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Rich West <Rich.West@wesmo.com>
Cc: autofs@linux.kernel.org


Rich West wrote:
>> Ian Kent wrote:
>>> On Tue, 2007-07-24 at 11:48 +0800, Ian Kent wrote:
>>>   
> After some tinkering I did finally figure things out.  It had to do with 
> the automountInformation field.
> 
> In the LDAP database, I had:
> automountInformation: ldap:ldap.mydomain.com:ou=auto.home,dc=mydomain,dc=com
> 
> I found (on an obscure posting elsewhere) that I could get it to work 
> via this entry:
> automountInformation: ldap:ou=auto.home,dc=mydomain,dc=com
> 
> Basically, I eliminated the LDAP server from the entry.  I'm going to 
> hazard a guess, but, since autofs sees that it is an ldap entry, it just 
> uses the system's bindings in order to resolve the ou...  Anyhow, it 
> works like a champ on FC5, FC6, and FC7.

Hi Rich,

Where are you setting the ldap server?  I have my ldap config in 
/etc/ldap.conf.  when  i start autofs with the following map in /etc/auto.master:

/home   ldap:ou=auto.home,dc=it,dc=ou,dc=edu

i see the following in my debug file:

Aug  7 08:58:35 leech automount[11991]: master_do_mount: mounting /home
Aug  7 08:58:35 leech automount[11991]: lookup_nss_read_map: reading map ldap 
ou=auto.home,dc=it,dc=ou,dc=edu
Aug  7 08:58:35 leech automount[11991]: parse_server_string: lookup(ldap): 
Attempting to parse LDAP information from string 
"ou=auto.home,dc=it,dc=ou,dc=edu".
Aug  7 08:58:35 leech automount[11991]: parse_server_string: lookup(ldap): 
server "(default)", base dn "ou=auto.home,dc=it,dc=ou,dc=edu"

.....

Aug  7 09:24:34 leech automount[3283]: lookup_init: lookup(ldap): cannot 
connect to server

not sure where to specify default server.  in this case, for replication, i 
guess a list of servers.  in ldap.conf i have:

uri ldaps://serve0 ldaps://serve1

so i am not sure that autofs will handle the ssl connections.

this would be really useful to get working so that the mounts have some 
failover potential.

ideas / suggestions?

tia


> 
> -Rich
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------
