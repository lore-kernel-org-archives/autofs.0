From: Ian Kent <raven@themaw.net>
Subject: Re: Map a single file??
Date: Sun, 03 May 2009 11:25:15 +0800
Message-ID: <49FD0E9B.7070505@themaw.net>
References: <49FCDEA9.2040804@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49FCDEA9.2040804@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

Stef Bon wrote:
> Hello,
> 
> I would like to know is it possible for the automounter to map a single 
> file?
> In KDE, the filemanagers Dolphin and Konqueror look for the file 
> .directory in every
> directory. In some cases I want to present a special .directory file. 
> The automounter is presenting a
> tree which consist of networks, workgroups, servers and shares. For the 
> network for example, the windows network folder icon would be something 
> like an windows icon. This can be set in the .directory file. Futher I 
> want these directories presented as icons, not in list.
> 
> So, can the automounter map single files, besides directories mapped to 
> networkmountpoints?

That's not functionality that belongs in the autofs.

This amounts to being able to "mount a single file" and AFAIK Linux
doesn't have this functionality at all and OSs that do have this only
for files that have specific support for particular files, such as
/etc/mnttab in Solaris.

Ian
