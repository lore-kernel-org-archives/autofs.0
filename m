From: Ian Kent <raven@themaw.net>
Subject: RE: getting parameters to executable maps
Date: Wed, 21 Jun 2006 11:26:35 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0606211121140.3748@raven.themaw.net>
References: <000101c68e5a$6f30d570$4d928050$@org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <000101c68e5a$6f30d570$4d928050$@org>
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
To: aptosca <aptosca@esseff.org>
Cc: autofs@linux.kernel.org

On Mon, 12 Jun 2006, aptosca wrote:

> I have a network service that defines a filesystem namespace. I'd like to
> write an executable map that uses that service to return map entries to
> automount. Abstractly, the executable map takes the namespace path, queries
> the web service, and returns a map entry to automount. The map entry is
> either a pointer to a real filesystem or an -fstype=autofs entry that causes
> the executable map to be executed again when/if an entry in the directory is
> touched.

I've thought about this and I can't think of any easy way to achieve this.

I don't like the idea of changing the internals of the way program maps 
are called.

One way to do this would be to write an autofs lookup module to handle 
this map source rather than use a program map.

Ian
