From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Tue, 13 Jan 2004 09:30:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0401130928480.10047-100000@wombat.indigo.net.au>
References: <20040112225023.GA21399@hockin.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040112225023.GA21399@hockin.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tim Hockin <thockin@hockin.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@Sun.COM>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 12 Jan 2004, Tim Hockin wrote:

> On Mon, Jan 12, 2004 at 11:26:30AM -0500, Mike Waychison wrote:
> > /usr   /man1   server:/usr/man1   \
> >          /man2   server:/usr/man2
> >
> > is the same as the two distinct entries:
> >
> > /usr/man1   server:/usr/man1
> > /usr/man2   server:/usr/man2
> >
> > Now that I think about it, the discussion in my proposal paper about
> > multimounts with no root offsets probably isn't required.
>
> The latter requires /usr/man1 and /usr/man2 to exist.  The former only
> requires /usr to exist, right?
>

That's one possibility, but man1 and man2 could simply not call filler in
the readdir call.

Ian
