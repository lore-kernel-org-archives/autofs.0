From: Ian Kent <raven@themaw.net>
Subject: Re: Can't mount shares ending in $
Date: Wed, 12 Mar 2008 12:14:15 +0900
Message-ID: <1205291655.2949.22.camel@raven.themaw.net>
References: <47D5CD16.5000807@edcint.co.nz>
	<1205198214.2955.7.camel@raven.themaw.net>
	<47D70295.2000709@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47D70295.2000709@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: autofs@linux.kernel.org


On Wed, 2008-03-12 at 09:07 +1100, Matthew Jurgens wrote:
> Hi Ian
> 
> For some reason, most of the messages I post to the list never show up
> - no idea why - so this time I am putting you on the receipt list as
> well - my reply is below. Thanks for you work on this product.
> 
> 
> 
> Before you sent this I installed the original Fedora 8 release of
> autofs (autofs-5.0.2-16).
> I had originally yum upgraded to Fedora 8 and so had been running on
> the latest version autofs-5.0.2-27.
> I have found that autofs-5.0.2-16 works fine, but going to -27 breaks
> it.
> 
> And the answer to your question, back on -27 version, is:
> With autofs running - no
> With autofs stopped - no
> With autofs stopped and when I mkdir /smb/matthew/C$ - yes

What I'm really after here is to find out whether the cifs mount is
choking on the unescaped $ in /smb/matthew/C$.

> 
> Ian Kent wrote: 
> > On Tue, 2008-03-11 at 11:06 +1100, Matthew Jurgens wrote:
> >   
> > > From the debug info, the mount command that fails is:
> > > mount -t cifs -s -o username=USER,password=PASSWORD //matthew/C\$ /smb/matthew/C$
> > >     
> > 
> > Does this command work if you run it manually?
> > 
> > Ian
> > 
> > 
> > 
> >   
