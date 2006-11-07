From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: problem with autofs
Date: Tue, 07 Nov 2006 11:07:14 -0500
Message-ID: <x497iy7xmtp.fsf@segfault.boston.devel.redhat.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	<x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
	<1162912613.18975.59.camel@localhost>
	<29c5cd460611070732h1cbdd998n3dd627c4e554b98a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611070732h1cbdd998n3dd627c4e554b98a@mail.gmail.com>
	(Syed Khader's message of "Tue, 7 Nov 2006 21:02:19 +0530")
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
To: Syed Khader <syedk@google.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] problem with autofs; "Syed Khader" <syedk@google.com> adds:

syedk> Hi Jeff,
syedk> AND  /usr/lib[64]/autofs/autofs-ldap-auto-master DOESn't give any ouput

That's bad.  What does the following show?

  ldapsearch -x -s subtree '(&(objectclass=automountMap)(ou=auto.master))'

Is the ldap server configured to allow anonymous binds?

-Jeff
