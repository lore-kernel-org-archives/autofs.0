From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Space in Samba share
Date: Fri, 2 Apr 2004 08:34:54 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200404020834.54851.robin.rosenberg.lists@dewire.com>
References: <200404011542.32440.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.58.0404020910560.19038@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404020910560.19038@wombat.indigo.net.au>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Friday 02 April 2004 03:13, Ian Kent wrote:
> What version autofs are you using.
>
> On Thu, 1 Apr 2004, Robin Rosenberg wrote:
> > How can I define a mount map that contains spaces in the share name
> > of a windows machine?
> >
> > I've tried some common ways of escaping the space to no avail.
> >
> > -fstype .... etc \
> > 	/local name //REMOTE/remote name
>
> Try escaping the spaces with a \.
> I'm not sure if this works with autofs v3 but remember a thread that
> implied it worked OK with v4.

Hmm, it works. Thanks. (I could have sworn I had tried it but.. ) :-) 

-- robin
