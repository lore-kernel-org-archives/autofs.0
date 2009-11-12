From: Ondrej Valousek <webserv@s3group.cz>
Subject: Automounter to dump maps
Date: Thu, 12 Nov 2009 14:21:47 +0100
Message-ID: <4AFC0BEB.3040808@s3group.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi Ian / all,

Is there any way to make automounter dump maps it sees? I was just 
thinking about it - with files / NIS / program backend it is not much 
needed but it could be quite helpful with ldap backend - restarting 
automounter with verbose logging is not too practical in the production 
environment.

I would imagine either some small standalone program using autofs 
internals which would dump all (or certain specified) maps or running a 
second instance of autofs (with some parameter) which would not mount 
anything and just dump the maps and exits.

Is this a completely misplaced idea or is there a way to achieve this 
functionality now?

Many thanks,
Ondrej
