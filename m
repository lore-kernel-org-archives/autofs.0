From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Exporting UID to userspace?
Date: Tue, 8 Jun 2004 00:53:33 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200406080053.33383.robin.rosenberg.lists@dewire.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841A4@frodo.avalon.ru>
	<40C49290.8060309@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40C49290.8060309@sun.com>
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
To: autofs@linux.kernel.org
Cc: Mike Waychison <Michael.Waychison@sun.com>

On Monday 07 June 2004 18.06, Mike Waychison wrote:
> My real problem with this RFE is that there is no indication on how you
> are planning to acquire the user credentials.
Does it matter if you know it  *is* possible. My idea is to do as I do today,
but with an extra lookup based on uid. That is the script executed by
automount would 

> For instance:
> - how are you going to acquire terminal information with just a uid/gid
> pair?
Simple case: don't need it. Assume the user has entered all info in a file
named ~uid/.autofs/credentials
host, share, remoteuid,remotepass

I'm a samba user so I could think of using Smb4K or similar to set up 

Or like the gpg agent that can bring up a window. 
~uid/.autofspipe

But I'd simply use the first version to start with.

> - how are you going to handle the case where there was no terminal?
> - what about when there was no terminal, but there were X resources
> available? (kernelspace wouldn't know anything about this at all..)

> Shouldn't this RFE also include some proposal for how you are going to
> ensure that only a single uid ever attempts access to the automounted
> directory as well? (if needed?)
Well, uh.. 
..good point. 

The directory can be shared if the permissions allow it so there is no 
absolute requirement for always separating users (but probably that is
the common need). But that's more of an extra feature for those file systems 
that support this.

I was thinking of ~uid/Network\ Neighborhood, but then autofs cannot do
/home/*/Network\ Neighborhood, I think.

Come to think of it.. There's a product called Sharity that does this. 
Actually it seem to do exactly what I want for CIFS without automount. 
Everything gets listed under /CIFS. The mount deamon talks to an agent 
running on the user's terminal, X or wherever the user decides and prompts 
for credentials if necessary. If no agent is running its can read info from a
pre-setup file or access will fail.

-- robin
