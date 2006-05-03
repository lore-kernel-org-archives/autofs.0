From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Wed, 3 May 2006 09:26:16 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605030917550.2664@raven.themaw.net>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060502173328.GA5006@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060502173328.GA5006@uio.no>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Tue, 2 May 2006, Steinar H. Gunderson wrote:

> On Tue, May 02, 2006 at 11:35:02PM +0800, Ian Kent wrote:
> > - Master map is now read and parsed by the `automount' daemon
> >   - the parameters for the `automount' daemon are now very different.
> >     See automount(8).
> 
> Ouch. Are there any plans for a conversion tool?

Maybe this is poorly worded.
Don't think any conversion tool is needed.

This was always done in the init script.
The master map would be parsed and individual daemons started.
Now the daemon reads and parses the master map taking all that 
troublesome logic from the init away.

The master map itself remains the same.

> 
> > - `autofs' version 5.0.0 will refuse to run if it cannot find an
> >    autofs4 kernel module that supports protocol version 5.00 or above.
> 
> What kernels are this?

See the INSTALL file in the tarball. It describes the requirements and 
included kernel patches. The changes are in the 2.6.17-rc series kernel 
now.

Let me know if you think we need more information.

Ian
