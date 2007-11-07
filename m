From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: LDAP Size limit exceeded
Date: Wed, 07 Nov 2007 11:14:06 -0500
Message-ID: <x49lk9ajanl.fsf@segfault.boston.devel.redhat.com>
References: <E5F741E838FC2043A0B843E48181813806AB75A8@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E5F741E838FC2043A0B843E48181813806AB75A8@MLNYC730MB.amrs.win.ml.com>
	(Edward Newman's message of "Tue\, 6 Nov 2007 18\:02\:15 -0500")
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
To: "Newman, Edward (GTI)" <edward_newman@ml.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

"Newman, Edward (GTI)" <edward_newman@ml.com> writes:

> In testing with one of our production maps imported into LDAP, came
> across this in debug log
>
> Nov  6 17:47:18 dnycxapec01 automount[6277]: read_one_map: lookup(ldap):
> query failed for (objectclass=nisObject): Size limit exceeded
>
> Looks like autofs cannot cope with more than 1000 entries and may need
> to look into use of LDAP page control for large maps. This was auto.home
> with several 000s of users.

The size limit is set by the server.  A simple workaround for you
would be to increase this size limit to the size of your largest map.

Ian, I guess we should add page control support to the TODO list.
rfc2696, for reference.


Cheers,

Jeff
