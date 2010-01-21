From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: debugging the automounter
Date: Thu, 21 Jan 2010 13:38:28 +0100
Message-ID: <1264077272-sup-3167@nixos>
References: <4B583D0D.1050700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <4B583D0D.1050700@gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs <autofs@linux.kernel.org>

Hi Phil,

first of all why don't you put the question why you need the debugger at
all? What makes you debugging autofs?

You're faced with PIE ( "position independent executable" )
Have a close look at the configure options and or the make flags.
I think you can switch it off. Also there are gdb versions which can
debug PIE. However I didn't suceed compiling them ( I didn't try very
hard)

HTH - good luck
Marc Weber
