From: Stef Bon <stef@bononline.nl>
Subject: Question about documentation/examples.
Date: Mon, 23 Jul 2007 12:23:27 +0200
Message-ID: <200707231223.27940.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

Hello,

I'm working on a construction which:
- automatic discovers the Windows (Samba) network (domains/hosts/shares) and builds a network tree in the home
directory of all the connected users 
- automatic mount the share on a per user basis when user or application wants to enter a share. Her I use autofs for.

It works very good. The following links helped me a lot:

http://www.howtoforge.com/accessing_windows_or_samba_shares_using_autofs
http://www.novell.com/coolsolutions/tip/19076.html

At this moment the setup I'm using works very good! I do not have to configure anything manually. 

Now, I would like to experiment more with the configuration of the various auto.* files. I've been looking for 
detailed documentation about it, but only found the manpages and an old guide on The Linux Documentation
Project.. This  howto is aged, and the manpages give - to me - only a global impression. Sorry for the one who has written those,
but I'm just trying te get familiar with autofs.. 

So my question is, is there documentation which can help me futher??

Thanks in advance,

Stef 
