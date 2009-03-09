From: Nathan Huesken <autofs@lonely-star.org>
Subject: autofs updating ghost direcotry for removable devices
Date: Mon, 9 Mar 2009 23:53:52 +0100
Message-ID: <20090309225352.GA22229@SamZwo>
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

Hi,

I am using autofs with the ghost parameter.
What I would like is autofs to update the "ghost directories" according
to removable devices plugged in or removed.
I found this:
http://code.google.com/p/hal-autofs/

This python program rewrites the autofs config file when a device is
plugged in or removed. Very good.
Now I need to figure out how to make autofs aware of these changes.
I could just restart autofs (I first need to refresh my python to do
that).

I wonder:

Could I get into trouble when restarting autofs while a autofs
managed device is mounted?

Does anybody have a better Idea of how to do what I want to do?

Thanks!
Nathan
