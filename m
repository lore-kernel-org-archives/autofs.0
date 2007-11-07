From: Ian Kent <raven@themaw.net>
Subject: Re: LDAP Size limit exceeded
Date: Thu, 08 Nov 2007 01:41:54 +0900
Message-ID: <1194453714.13416.76.camel@raven.themaw.net>
References: <E5F741E838FC2043A0B843E48181813806AB75A8@MLNYC730MB.amrs.win.ml.com>
	<x49lk9ajanl.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49lk9ajanl.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, "Newman, Edward (GTI)" <edward_newman@ml.com>

On Wed, 2007-11-07 at 11:14 -0500, Jeff Moyer wrote:
> "Newman, Edward (GTI)" <edward_newman@ml.com> writes:
> 
> > In testing with one of our production maps imported into LDAP, came
> > across this in debug log
> >
> > Nov  6 17:47:18 dnycxapec01 automount[6277]: read_one_map: lookup(ldap):
> > query failed for (objectclass=nisObject): Size limit exceeded
> >
> > Looks like autofs cannot cope with more than 1000 entries and may need
> > to look into use of LDAP page control for large maps. This was auto.home
> > with several 000s of users.
> 
> The size limit is set by the server.  A simple workaround for you
> would be to increase this size limit to the size of your largest map.
> 
> Ian, I guess we should add page control support to the TODO list.
> rfc2696, for reference.

Yes, I had a look at what's needed today, very briefly.
One day we'll get back to writing automounting code, ;)

Ian
