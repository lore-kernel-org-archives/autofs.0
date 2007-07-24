From: Rich West <Rich.West@wesmo.com>
Subject: Re: autofs5 + ldap + ldap replication
Date: Tue, 24 Jul 2007 12:55:33 -0400
Message-ID: <46A62F05.4040806@wesmo.com>
References: <469985DF.9010607@wesmo.com>	<1184599068.3344.5.camel@raven.themaw.net>	<469BB868.4080603@wesmo.com>	<x497ip0w4xj.fsf@segfault.boston.devel.redhat.com>	<469BCCF4.50608@wesmo.com>
	<1184653232.3188.37.camel@raven.themaw.net>	<46A4D959.8080703@wesmo.com>	<1185248927.3185.30.camel@raven.themaw.net>
	<1185249375.3185.33.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1185249375.3185.33.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian Kent wrote:
> On Tue, 2007-07-24 at 11:48 +0800, Ian Kent wrote:
>   
>> On Mon, 2007-07-23 at 12:37 -0400, Rich West wrote:
>>     
>>> Ian Kent wrote:
>>>       
>>>> On Mon, 2007-07-16 at 15:54 -0400, Rich West wrote:
>>>>   
>>>>         
>>>>> Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
>>>>> lookup(ldap): searching for "(objectclass=automount)" under
>>>>> "ou=auto.master,dc=mydomain,dc=com"
>>>>> Jul 16 15:21:08 myhost automount[1852]: lookup_read_master:
>>>>> lookup(ldap): examining entries
>>>>> Jul 16 15:21:08 myhost automount[1852]: master_echo: .
>>>>> Jul 16 15:21:08 myhost automount[1852]: master_echo: .
>>>>> Jul 16 15:21:08 myhost automount[1852]: master_echo: :
>>>>> Jul 16 15:21:08 myhost automount[1852]: master_echo: .
>>>>>     
>>>>>           
>>>> This is a parse error that's not being handled.
>>>> What autofs is getting from the LDAP server can't be the same as what
>>>> it's getting from the master if the master is working.
>>>>
>>>> Can you give us an example of the output from an LDAP search to both the
>>>> servers please.
>>>>         
>>> Sorry for the long delay.. I missed this one.
>>>
>>> Both servers are running the same version of openldap.  You have the
>>> output from the bad search.  I turned up logging and reloaded autofs on
>>> the master server and got the following (was that what you were looking
>>> for?):
>>>       
>> I was hoping to get the output from an ldapsearch for one of the maps
>> from both servers.
>>     
>
> Actually, the parse fail happened for the master map.
> How about an ldapsearch for that on bothe servers.

Ok.. Sorry about that, too.

master#> ldapsearch -x -b ou=auto.master,dc=mydomain,dc=com
'(objectclass=automount)' -LLL -h localhost
dn: cn=/home,ou=auto.master,dc=wesmo,dc=com
objectClass: automount
cn: /home
automountInformation: ldap:ldap.wesmo.com:ou=auto.home,dc=wesmo,dc=com


replica#> ldapsearch -x -b ou=auto.master,dc=mydomain,dc=com
'(objectclass=automount)' -LLL -h localhost
dn: cn=/home,ou=auto.master,dc=mydomain,dc=com
objectClass: automount
cn: /home
automountInformation: ldap ldap.mydomain.com:ou=auto.home,dc=mydomain,dc=com

I just noticed that the replica is returning "ldap ldap.mydomain.com"
which is missing the colon between "ldap" and "ldap.mydomain.com". 
That's odd.  When I look at things from phpldapadmin, the entries look
exactly the same on both machines.  The master server is a Fedora Core 5
box, and the replica is a Fedora Core 6 box.

-Rich
