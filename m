From: Heinrich Rebehn <rebehn@ant.uni-bremen.de>
Subject: Re: Cannot see automount point subdirecties
Date: Wed, 16 Aug 2006 10:46:25 +0200
Message-ID: <44E2DB61.8050101@ant.uni-bremen.de>
References: <20060814164342.3014.qmail@web56408.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060814164342.3014.qmail@web56408.mail.re3.yahoo.com>
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
To: csarid <csarid@yahoo.com>
Cc: autofs@linux.kernel.org

csarid wrote:
> Hello,
>    
>   I am running linux kernal version 2.4 automounting files using nis. The issue is that after I, for instanced "cd /programs" and then do an "ls -la" no subdirectories showup unless I explicitly change directory to a subdirectory. Otherwise, no files or directories are listed. 
>    
Is the automount process running with "-g" or "--ghost" ?
Also, i have seen that if you compile the kernel with both autofs v3 
*and* v4, ghosting will not work.

--
Heinrich Rebehn

University of Bremen
Physics / Electrical and Electronics Engineering
- Department of Telecommunications -

Phone : +49/421/218-4664
Fax   :            -3341
