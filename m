From: Gerald Teschl <gerald@esi.ac.at>
Subject: Re: autofs RFE
Date: Mon, 8 Dec 2003 13:35:33 +0100 (CET)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312081320340.18368-100000@keen.esi.ac.at>
References: <Pine.LNX.4.44.0312081929510.3866-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312081929510.3866-100000@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 8 Dec 2003, Ian Kent wrote:

> On Mon, 8 Dec 2003, Gerald Teschl wrote:
> 
> > 
> > The ideal solution would be to make the mount call as the user requesting
> > the mount, but if I understand you right, this is to complex to find out.
> > So the solution to this problem should be the following:
> > If the "owner" option is present, do the mount call as the user owning
> > the device file.
> 
> Umm...
> That should work.
> Can we always relly on the device owner to be the correct owner for the 
> mount (when the owner option is specified) or is this a security risk?
> Comments please.

1) It is as secure as the original "console user" concept
used by RedHat and most others - which is definitely better than the
"floppy group" concept. Moreover, if pam should fail to set the
ownership you are hosed anyway: the dev owner has full access to the
dev, so autofs doesn't give this user anything she/he die not have
before (except for convennience;-).

2) It is optional via the "owner" option. So the admin has to enable it
and then live with the consequences;-)


> So short answer is yes, if all goes well, but I can't commit to when. I'll 
> know more once I start the comming development phase.
Nobody is pushing you. Take your time!

Thanks,

Gerald
