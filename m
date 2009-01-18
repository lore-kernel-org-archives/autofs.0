From: webserv@s3group.com
Subject: Re: auto.master in ldap + simple bind
Date: Sun, 18 Jan 2009 19:01:46 -0000 (GMT)
Message-ID: <4608.82.208.2.231.1232305306.squirrel@webmail.s3group.com>
References: <49709FA6.1040203@s3group.cz>
	<1232122347.3166.102.camel@zeus.themaw.net>
	<1232168581.3072.0.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232168581.3072.0.camel@zeus.themaw.net>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi Ian,
I tried that already, also played with several authtypes and still no joy.
So I enabled autofs debugging and saw that no matter what I try,
automounter tries to bind anonymously - that fails with AD. I need to bind
using the proxy user...
Thanks,
Ondrej
> On Sat, 2009-01-17 at 01:12 +0900, Ian Kent wrote:
>> On Fri, 2009-01-16 at 15:54 +0100, Ondrej Valousek wrote:
>> > Hi all,
>> > I am trying to configure autofs (RHEL 5.2) to gather all maps from
>> > Active Directory using simple bind using proxy user.
>> > I have already managed to configure the PADL nss switch to do so using
>> this:
>> >
>> > host 192.168.60.172
>> > base dc=ad,dc=s3group,dc=cz
>> > binddn cn=ldapproxy,cn=Users,dc=ad,dc=s3group,dc=cz
>> > bindpw password
>> >
>> > Now I am wondering how to do the same with the automounter. Does
>> anyone
>> > know?
>> > I see lots of options on how to configure TLS or SASL, but I just need
>> a
>> > simple bind.
>>
>> This might work.
>>
>> authrequired="yes"
>> user="cn=ldapproxy,cn=Users,dc=ad,dc=s3group,dc=cz"
>> secret="password"
>>
>> You might also need to play with authtype.
>
> Of course that's contained in /etc/autofs_ldap_auth.conf
>
>>
>> Ian
>>
>>
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>
>



The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited. Registered in Ireland no. 378073.
Registered Office: South County Business Park, Leopardstown, Dublin 18
