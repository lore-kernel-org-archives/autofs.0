From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Subject: RE: Another (stupid) question: autofs vs nfs for
	automounting purposes
Date: Mon, 14 Jun 2004 11:59:24 +0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3841AF@frodo.avalon.ru>
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
> From: raven@themaw.net [mailto:raven@themaw.net] 
> 
> On Fri, 11 Jun 2004, Dimitry V. Ketov wrote:
> 
> > - Which reasons (besides simplicity) led developers to the autofs 
> > solution?
> > - What's wrong with nfs for the same things?
> 
> I don't understand your question.
> 
> What has NFS to do with automounting?
Sorry, if I'm unclear.
I really meant communication protocol between kernel and the userspace
for automounting purposes.
As I know, early automounting solutions was (and current am-utils is)
based on userspace nfs server daemon that mount itself on the autmomount
points and then listen for filesystem traverses that trigger mounting.
I understand that nfs was designed for different purposes, but anyway
what reason to design new communication protocol and to complicate
kernel instead using already in-kernel nfs code?

Dimitry.
