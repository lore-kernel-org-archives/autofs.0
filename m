From: "Lever, Charles" <Charles.Lever@netapp.com>
Subject: RE: replicated mounts patch
Date: Wed, 20 Apr 2005 09:13:13 -0700
Message-ID: <482A3FA0050D21419C269D13989C6113085399F5@lavender-fe.eng.netapp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: Jeffrey Layton <jtlayton@poochiereds.net>, raven@themaw.net
Cc: autofs@linux.kernel.org

jeffrey-

> > We've had complaints about ports and protocols being 
> blocked for the 
> > rpc_ping function.
> > 
> > Any thoughts on how to work around that?
> 
> My patch should address this somewhat -- it looks for the 
> 'tcp' and 'nfsvers=' mount options and does the RPC ping 
> according to those. So if the ping doesn't work due to 
> blocked ports, then the mount won't work either.

if the mount option default settings change (say it was 'udp' in earlier
releases, and is now 'tcp') the meaning of a missing option on the mount
command line is different.

so looking at the mount options is a completely unreliable way to
determine which transport protocol is in use...
