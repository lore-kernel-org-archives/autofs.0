From: Ian Kent <raven@themaw.net>
Subject: Re: New autofs behavior in RHEL 4U6
Date: Tue, 26 Feb 2008 11:10:40 +0900
Message-ID: <1203991840.3173.4.camel@raven.themaw.net>
References: <620E93B2E5CC3B46BD811165E3335B87165B9D@0461-its-exmb02.us.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <620E93B2E5CC3B46BD811165E3335B87165B9D@0461-its-exmb02.us.saic.com>
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
To: "Murata, Dennis" <DENNIS.MURATA@saic.com>
Cc: autofs@linux.kernel.org


On Mon, 2008-02-25 at 15:28 -0800, Murata, Dennis wrote:
> >From the man pages it looks like the multi feature is no longer
> supported.  I can get the failover behavior to work if I use a map like
> auto.foo:
> *  -fstype=nfs,rsize=32768,intr server:/local/too/& server:/local/foo/&
> 
> The desired result is to have mounts from /local/too to be rw, those
> from /local/foo ro, is this possible?  I have the exports on the server
> as ro and rw, but all the mounts on the workstation so far seem to be
> ro.

Are these exports from the same filesystem?
If they are then all the mounts will inherit the options of the first
made mount (at least I think that's kernel behaves like that).

Ian
