From: Rich West <Rich.West@wesmo.com>
Subject: Re: autofs5 + ldap + ldap replication
Date: Mon, 06 Aug 2007 21:32:42 -0400
Message-ID: <46B7CBBA.7080105@wesmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
References: 46A62F05.4040806@wesmo.com
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
To: autofs@linux.kernel.org

>
> Ian Kent wrote:
> > On Tue, 2007-07-24 at 11:48 +0800, Ian Kent wrote:
> >   
> >> On Mon, 2007-07-23 at 12:37 -0400, Rich West wrote:
> >>     
> >>> Ian Kent wrote:
> >>>       
> >>>> On Mon, 2007-07-16 at 15:54 -0400, Rich West wrote:
> >>>>   
> >>>>         
> >>>>> Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
> >>>>> lookup(ldap): searching for "(objectclass=automount)" under
> >>>>> "ou=auto.master,dc=mydomain,dc=com"
> >>>>> Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
> >>>>> lookup(ldap): examining entries
> >>>>> Jul 16 15:21:08 myhost automount[1852]: master_echo: .
> >>>>> Jul 16 15:21:08 myhost automount[1852]: master_echo: .
> >>>>> Jul 16 15:21:08 myhost automount[1852]: master_echo: :
> >>>>> Jul 16 15:21:08 myhost automount[1852]: master_echo: .
> >>>>>     
> >>>>>           
> >>>> This is a parse error that's not being handled.
> >>>> What autofs is getting from the LDAP server can't be the same as what
> >>>> it's getting from the master if the master is working.
> >>>>
> >>>> Can you give us an example of the output from an LDAP search to both the
> >>>> servers please.
> >>>>         
> >>> Sorry for the long delay.. I missed this one.
> >>>
> >>> Both servers are running the same version of openldap.  You have the
> >>> output from the bad search.  I turned up logging and reloaded autofs on
> >>> the master server and got the following (was that what you were looking
> >>> for?):
> >>>       
> >> I was hoping to get the output from an ldapsearch for one of the maps
> >> from both servers.
> >>     
> >
> > Actually, the parse fail happened for the master map.
> > How about an ldapsearch for that on bothe servers.
>
> Ok.. Sorry about that, too.
>
> master#> ldapsearch -x -b ou=auto.master,dc=mydomain,dc=com
> '(objectclass=automount)' -LLL -h localhost
> dn: cn=/home,ou=auto.master,dc=mydomain,dc=com
> objectClass: automount
> cn: /home
> automountInformation: ldap:ldap.mydomain.com:ou=auto.home,dc=mydomain,dc=com
>
>
> replica#> ldapsearch -x -b ou=auto.master,dc=mydomain,dc=com
> '(objectclass=automount)' -LLL -h localhost
> dn: cn=/home,ou=auto.master,dc=mydomain,dc=com
> objectClass: automount
> cn: /home
> automountInformation: ldap ldap.mydomain.com:ou=auto.home,dc=mydomain,dc=com
>
> I just noticed that the replica is returning "ldap ldap.mydomain.com"
> which is missing the colon between "ldap" and "ldap.mydomain.com". 
> That's odd.  When I look at things from phpldapadmin, the entries look
> exactly the same on both machines.  The master server is a Fedora Core 5
> box, and the replica is a Fedora Core 6 box.

After some tinkering I did finally figure things out.  It had to do with 
the automountInformation field.

In the LDAP database, I had:
automountInformation: ldap:ldap.mydomain.com:ou=auto.home,dc=mydomain,dc=com

I found (on an obscure posting elsewhere) that I could get it to work 
via this entry:
automountInformation: ldap:ou=auto.home,dc=mydomain,dc=com

Basically, I eliminated the LDAP server from the entry.  I'm going to 
hazard a guess, but, since autofs sees that it is an ldap entry, it just 
uses the system's bindings in order to resolve the ou...  Anyhow, it 
works like a champ on FC5, FC6, and FC7.

-Rich
