From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: automount does not close file descriptors at start
Date: Wed, 16 Feb 2005 23:57:35 +0100
Message-ID: <20050216225735.GA17086@uio.no>
References: <20050216125350.GA6031@uio.no>
	<Pine.LNX.4.61.0502162301590.8161@donald.themaw.net>
	<20050216222749.GA19214@ba.issia.cnr.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20050216222749.GA19214@ba.issia.cnr.it>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Wed, Feb 16, 2005 at 11:27:49PM +0100, Francesco P. Lovergine wrote:
>> And you would like to substantiate that, right!
> Err, maybe closing stdin,stdout and stderr? 

No. Everything up to MAXFDS.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
