From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Newbie Question
Date: Thu, 12 Aug 2004 15:31:44 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16667.50592.133899.865367@segfault.boston.redhat.com>
References: <411BAE2F.8040309@analog.com>
	<16667.46801.458839.821849@segfault.boston.redhat.com>
	<411BBA84.7030009@analog.com>
	<16667.49462.344049.857207@segfault.boston.redhat.com>
	<411BC4F6.1000801@analog.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <411BC4F6.1000801@analog.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: "Anne.Bourgeois" <anne.bourgeois@analog.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Newbie Question; "Anne.Bourgeois" <anne.bourgeois@analog.com> adds:

>> [snip]
>> 
>> Well, it's probably okay.  It's definitely okay if you're not using
>> ldap.  ;)
>> 
>> 
>> Hope this helps!
>> 
>> -Jeff
>> 
anne> OK, I'm not using LDAP.  I will just go with install with the
anne> --nodeps flag & try it that way.  If I have problems, I'll try
anne> installing the kernel patches.

I thought you needed the map expiry changes?  If so, you need to install at
least the patch attached to my last email.  There are also known issues
with the autofs4 module that ships with the RH 8 kernel that are fixed with
Ian's patch sets.  If you run into further problems, we will likely ask you
to update your kernel before we help out.

-Jeff
