From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: RE: Exporting UID to userspace?
Date: Mon, 7 Jun 2004 16:45:22 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3841A4@frodo.avalon.ru>
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org



> -----Original Message-----
> From: Robin Rosenberg [mailto:robin.rosenberg.lists@dewire.com] 
> 
> On Saturday 05 June 2004 17.52, raven@themaw.net wrote:
> ..
> > How will you provide a consistent Unix UID <-> Windows UID mapping? 
> > And on multiple machines for the same user, over OS re-install? Ian
> 
> cases you can use a mapping table in the script that 
> automount calls. Autofs should just provide the local uid,gid 
> from the calling process.

Yes, you're definitely right. In fact I want this finctionality just for
'program' maps, lets say UID, GID and supplementary GIDs like a second,
third, so on ... parameters to the map script.

Dimitry.
