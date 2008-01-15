From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Query automount maps
Date: Tue, 15 Jan 2008 15:48:25 -0500
Message-ID: <x49tzlex1ba.fsf@segfault.boston.devel.redhat.com>
References: <BAC1D28A5AB852439A6914CA7AB4E63F051929F0@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F051929F0@permls05.wde.woodside.com.au>
	(Colin C. Coe's message of "Tue\, 15 Jan 2008 07\:55\:22 +0900")
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org

"Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au> writes:

> Hi Ian and all
>
> Is there a way I can ask the automount process running on a client what
> maps it has?  I'd like to be able to say "tell me all the maps you know
> about" or "tell me the server:/path/to/somewhere for
> /nfs/server/some/path".  Does this make sense?
[...]
> I'm really just after a way of checking that autofs map changes are
> picked up by the clients.

It doesn't actually make sense, and here's why: the automounter won't
recognize the update until a mount is triggered.  As such, you can
just trigger a mount and compare what gets mounted with what you
expect.  Is there some reason that this won't work for you?

Cheers,

Jeff
