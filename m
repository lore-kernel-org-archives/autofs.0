From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: Re: [PATCH 0/4] Current state of Vals patches and the file
	map lookup patches
Date: Mon, 19 Jan 2009 22:26:11 -0500
Message-ID: <20090120032611.GB1525@shell>
References: <20090119121918.31454.61737.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090119121918.31454.61737.stgit@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Paul Wankadia <junyer@google.com>

On Mon, Jan 19, 2009 at 09:24:33PM +0900, Ian Kent wrote:
> I've pulled in the patches that Val posted and made a couple of
> minor changes. I also have what I think is just about what we
> need to reduce the overhead of file map scanning.

Great, thank you!

> Check'em out please folks.

I have a crumpled post-it note on my desk saying "valgrind automount."
How hard would this be to do while running the Connectathon suite?  It
would sure make me feel better about these patches.

> I'm a little concerned about the "fix kernel includes" patch because
> there should be more to it and I've altered it in line with that. I'm
> not sure if we should post a kernel patch first, pull in the updated
> kernel header files to the tar and finally make the other couple of
> changes then. But then I may have it wrong so check it out.

Yeah, there's a trade-off there.  I think the approach you've taken is
the most sensible, given that nothing makes me more insane than out of
sync user and kernel code.

-VAL
