From: Ian Kent <raven@themaw.net>
Subject: Re: chained configs (and ghost too)
Date: Tue, 16 Mar 2004 11:15:57 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403161114380.12290@wombat.indigo.net.au>
References: <1079380607.4327.59.camel@jade.biology.duke.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1079380607.4327.59.camel@jade.biology.duke.edu>
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
To: Hunter Matthews <thm@duke.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 15 Mar 2004, Hunter Matthews wrote:

> All, Thanks to nalin and steve, I've gotten autofs working with LDAP. 
> 
> I haven't seen this in the docs, nor in my quick scan of the archives.
> So, for others wondering how, here is the working configuration:
> 
> In nis, I had a table called auto.biology: 
> groups -fstype=autofs  yp:auto.groups
> zzz balh:/local/zzz
> ftp ftp:/local/ftp
> ....

I see. I don't have an example of a submount in the distribution.
I'll have to fix that.

Ian
