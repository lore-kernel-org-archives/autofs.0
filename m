From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: RE: Exporting UID to userspace?
Date: Tue, 8 Jun 2004 21:47:21 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B384E39FF@frodo.avalon.ru>
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
> On Monday 07 June 2004 18.06, Mike Waychison wrote:
> > - how are you going to acquire terminal information with just a
> > uid/gid pair?
> Simple case: don't need it. Assume the user has entered all
> info in a file named ~uid/.autofs/credentials
> host, share, remoteuid,remotepass
Yes, I supposed the same trivial way to deal with that.

> > Shouldn't this RFE also include some proposal for how you 
> are going to 
> > ensure that only a single uid ever attempts access to the 
> automounted 
> > directory as well? (if needed?)
> Well, uh.. 
> ..good point. 
> I was thinking of ~uid/Network\ Neighborhood, but then autofs 
> cannot do /home/*/Network\ Neighborhood, I think.
I think it is possible to spawn a new automount process (with the
~uid/Network\ Neighborhood automount-point and the special executable
map) for every logged user, with the help of the special pam module.

Dimitry.
