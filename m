From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: problem with autofs
Date: Tue, 07 Nov 2006 14:01:48 -0500
Message-ID: <x493b8vxeqr.fsf@segfault.boston.devel.redhat.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	<x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
	<1162912613.18975.59.camel@localhost>
	<29c5cd460611070732h1cbdd998n3dd627c4e554b98a@mail.gmail.com>
	<x497iy7xmtp.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070820o6cb2a08fp2c9e9adf67651ce3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611070820o6cb2a08fp2c9e9adf67651ce3@mail.gmail.com>
	(Syed Khader's message of "Tue, 7 Nov 2006 21:50:06 +0530")
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
syedk> Here's the output

>> ldapsearch -x -s subtree '(&(objectclass=automountMap)(ou=auto.master))'

syedk> dn:ou=auto.master,dc=testlab,dc=com
syedk> objectClass:top
syedk> objectClass:automountMap
syedk> ou:auto.master

syedk> I have configured to allow anonymous bind.No ACLS are given

OK, then what do you get with this:

ldapsearch -x -s subtree -b 'ou=auto.master,dc=testlab,dc=com' 'objectclass=automount'

-Jeff
