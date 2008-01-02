From: "Jerzy Jalocha N" <jjalocha@gmail.com>
Subject: Re: basic SOHO NFS/autofs setup for noob help
Date: Wed, 2 Jan 2008 13:37:51 -0600
Message-ID: <9b72f9a90801021137m38452b54s7a9af7a53967374e@mail.gmail.com>
References: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>
	<x49lk7812d7.fsf@segfault.boston.devel.redhat.com>
	<9b72f9a90801021110k3b3d74e7kb227b1e5bb772544@mail.gmail.com>
	<x49hchw117z.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49hchw117z.fsf@segfault.boston.devel.redhat.com>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

> Of course it shows nothing.  What directories exist under /shared on
> the server?  Try to cd to one of those.

Sorry, I am not very clear what I should expect from autofs, so I
didn't post everything I've tested. But I've also tried to show the
contents of a sub-directory without success:
 $ ls /shared/subdir
or
 $ cd /shared/subdir
(for some directory I know that exists.)
But this just takes around 10 min to tell me that there's "No such
file or directory".

> If you want the directory names to appear in a listing of /shared,
> then you would have to have a separate key in the auto.shared map for
> each of the directories (instead of using the wildcard key).

Thanks, this will surely be useful once I get it running. :)
