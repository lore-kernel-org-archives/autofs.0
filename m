From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: multi-level deep ldap automount possible?
Date: Fri, 06 Jun 2008 10:10:12 -0400
Message-ID: <x49lk1id58b.fsf@segfault.boston.devel.redhat.com>
References: <10badf220806042312p6ca4adf0h5836a8e046f2075a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10badf220806042312p6ca4adf0h5836a8e046f2075a@mail.gmail.com>
	(Shane's message of "Thu, 5 Jun 2008 15:42:24 +0930")
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
To: Shane <squindler@gmail.com>
Cc: autofs@linux.kernel.org

Shane <squindler@gmail.com> writes:

> Hello,
>
> Hoping someone can help me figure out if its possible to do
> multi-level deep automounts via ldap. I've seen a few examples of this
> using files but can't get it to work using LDAP.
>
> eg I want:
> server1:/export/protemp  -  /nfs/tmp/production
> server2:/export/tmp/weekly  -  /nfs/tmp/weekly
> server2:/export/tmp/hourly  -  /nfs/tmp/hourly
>
> pseudo ldap implementation

It's better to just include your ldif.  Your pseudo code doesn't make
any sense to me.  My guess is that you want something like the
following:

dn: ou=auto.master,dc=<DOMAIN1>,dc=<DOMAIN2>
objectClass: automountMap
objectClass: organizationalUnit

dn: cn=/nfs,ou=auto.master,dc=<DOMAIN1>,dc=<DOMAIN2>
objectClass: automount
automountInformation: auto.nfs

dn: ou=auto.nfs,dc=<DOMAIN1>,dc=<DOMAIN2>
objectClass: organizationalUnit
objectClass: automountMap

dn: automountKey=tmp,ou=auto.nfs,dc=<DOMAIN1>,dc=<DOMAIN2>
automountKey: tmp
automountInformation: -rw,hard,intr,tcp  /production server1:/export/protemp /weekly server2:/export/tmp/weekly /hourly server2:/export/tmp/hourly


I didn't test the above, so there may be problems with my ldif -- sorry!

If you haven't decided on a schema to use yet, then I'd recommend
rfc2307bis.  The schema above uses cn, which is not case sensitive.

Cheers,

Jeff
