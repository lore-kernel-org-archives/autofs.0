From: Michael Blandford <michael@kmaclub.com>
Subject: Re: Problem with autofs 3.1.7 -> 4.1.0-beta2
Date: Sun, 07 Dec 2003 15:15:14 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FD3A672.20405@kmaclub.com>
References: <Pine.LNX.4.44.0312072016350.3078-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312072016350.3078-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent wrote:

>Which schema are you using the nisMap or automountMap.
>
>  
>
automountMap

>I'll need an ldif example in order to duplicate the problem.
>
>  
>
Names are changed to protect the innocent.

# auto.master, kmaclub, com
dn: ou=auto.master,dc=kmaclub,dc=com
objectClass: top
objectClass: automountMap
ou: auto.master

# /services, auto.master, kmaclub, com
dn: cn=/services, ou=auto.master,dc=kmaclub,dc=com
objectClass: automount
automountInformation: ldap:ou=auto.services,dc=kmaclub,dc=com
cn: /services

# auto.services, kmaclub, com
dn: ou=auto.services,dc=kmaclub,dc=com
objectClass: top
objectClass: automountMap
ou: auto.services

# /, auto.services, kmaclub, com
dn: cn=/,ou=auto.services,dc=kmaclub,dc=com
objectClass: automount
automountInformation: fileserver:/export/services/&
cn: /

# mounta, auto.services, kmaclub, com
dn: cn=mounta,ou=auto.services,dc=kmaclub,dc=com
objectClass: automount
cn: mounta
automountInformation: fileserver:/export2/mounta

# mountb, auto.services, kmaclub, com
dn: cn=mountb,ou=auto.services,dc=kmaclub,dc=com
objectClass: automount
cn: mountb
automountInformation: fileserver:/export2/mountb

# mountc, auto.services, kmaclub, com
dn: cn=mountc,ou=auto.services,dc=kmaclub,dc=com
objectClass: automount
cn: mountc
automountInformation: fileserver:/export2/mountc

# mountd, auto.services, kmaclub, com
dn: cn=mountd,ou=auto.services,dc=kmaclub,dc=com
objectClass: automount
cn: mountd
automountInformation: fileserver:/export2/mountd
~

>>According to the automount man page, the wildcard for ldap is a / so 
>>that is what I was using.  What I thought was odd was it was always 
>>choosing the same thing and it *wasn't* the wildcard.
>>    
>>
>
>Think the code is incorrect.
>
>  
>
I reloaded autofs-4.1.0-beta2 again today just to play.  What I have 
found is cd'ing into /services/asdlfjadalsdjfaklsdjf will also suceed 
and give me a mount to fileserver:/export2/mountb even though the mount 
should fail.

Michael
