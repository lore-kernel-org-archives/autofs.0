From: Ian Kent <raven@themaw.net>
Subject: Re: Low priority question: negative cache in autofs5
Date: Fri, 05 Dec 2008 20:48:36 +0900
Message-ID: <1228477716.3033.37.camel@zeus.themaw.net>
References: <493910C7.9010308@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <493910C7.9010308@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-12-05 at 12:30 +0100, Ondrej Valousek wrote:
> Probably to Ian:
> I am just looking in the autofs5 (from RHEL5) source. I have an indirect
> nis map:
> auto.master:
> /appli auto.appli
> /proj auto.proj
> 
> Now, auto.proj contains a wildcard entry (* nfsserver:/share/&) but
> auto.appli does not.
> 
> 1. Every time I try to enter (shortly after each other)
> /proj/nonexistent_directory, I got this:
> Dec  5 12:10:45 ara automount[3101]: rmdir_path: lstat of
> /proj/nonexistent_directory failed
> ... why did not the negative cache save us the expensive call to lstat?
> 
> 
> 2. Every time I try to enter (shortly after each other)
> /appli/nonexistent_directory, I got this:
> Dec  5 12:11:41 ara automount[3101]: lookup_mount: lookup(yp): key
> "nonexistent" not found in map
> ... again, looks like the nis daemon was consulted but the negative
> cache should take the place.

Known bug with v5 handling of negative caching of non-existent keys.
I'm working on it but it is proving a little bit tricky because of
possible multiple map sources listed in nsswitch.conf (at least that's
where I'm currently at).

> 
> Maybe I do not understand the concept of negative caching well....

No .. you got it right .. I missed it.

Another thing, there are quite a few changes going into RHEL-5.3 autofs
which will make their way into RHEL-4.8 in due course. Hopefully you
will not get caught by them but it is worth logging calls for issues in
case you are seeing a known issue.

Ian
