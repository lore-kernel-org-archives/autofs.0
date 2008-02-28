From: Stef Bon <stef@bononline.nl>
Subject: UID not always available.
Date: Thu, 28 Feb 2008 20:20:21 +0100
Message-ID: <47C70975.2090505@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

I know there is some discussion about patches concerning the uid of the 
user/proces activating the mount.
I've been experimenting with it (I've posted some messages before about 
it) and it works, what is very good news.

In my construction the automounter can activate a mount using the 
credentials of another user.
So this information about user activating the mount is very usefull. An 
user can only get mounts using
his own credentials, or as guest.

But it's not working always. In about 40% of the cases the USER field is 
empty.

Is this behaviour reckognized? Or do I have to supply more info?
More info you can read in my post of 11 februari this year.

Stef Bon
